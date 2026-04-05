import os
import random
import time
from decimal import Decimal, ROUND_HALF_UP

import psycopg2
from faker import Faker
from psycopg2 import OperationalError


fake = Faker()


def env(name: str, default: str) -> str:
    return os.getenv(name, default)


DB_CONFIG = {
    "host": env("DB_HOST", "postgres"),
    "port": int(env("DB_PORT", "5432")),
    "dbname": env("DB_NAME", "postgres"),
    "user": env("DB_USER", "postgres"),
    "password": env("DB_PASSWORD", "postgres"),
}

SLEEP_MIN = float(env("SLEEP_MIN_SECONDS", "0.5"))
SLEEP_MAX = float(env("SLEEP_MAX_SECONDS", "1.0"))


def as_money(value: float) -> Decimal:
    return Decimal(value).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)


def connect_with_retry():
    while True:
        try:
            conn = psycopg2.connect(**DB_CONFIG)
            conn.autocommit = False
            print("Connected to PostgreSQL")
            return conn
        except OperationalError as exc:
            print(f"PostgreSQL not ready, retrying in 2s: {exc}")
            time.sleep(2)


def insert_order(conn):
    customer_id = fake.random_int(min=1, max=50000)
    order_status = fake.random_int(min=1, max=5)
    item_count = fake.random_int(min=1, max=5)

    detail_rows = []
    total_due = Decimal("0.00")

    for _ in range(item_count):
        order_qty = fake.random_int(min=1, max=10)
        unit_price = as_money(
            float(
                fake.pydecimal(
                    left_digits=3,
                    right_digits=2,
                    positive=True,
                    min_value=5,
                    max_value=500,
                )
            )
        )
        line_total = as_money(unit_price * Decimal(order_qty))
        detail_rows.append(
            (
                fake.random_int(min=1, max=1000),
                order_qty,
                unit_price,
                line_total,
            )
        )
        total_due += line_total

    with conn.cursor() as cur:
        cur.execute(
            """
            INSERT INTO SalesOrderHeader (OrderDate, DueDate, Status, CustomerID, TotalDue, ModifiedDate)
            VALUES (NOW(), NOW() + INTERVAL '1 day', %s, %s, %s, NOW())
            RETURNING SalesOrderID
            """,
            (order_status, customer_id, total_due),
        )
        sales_order_id = cur.fetchone()[0]

        for product_id, order_qty, unit_price, line_total in detail_rows:
            cur.execute(
                """
                INSERT INTO SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice, LineTotal, ModifiedDate)
                VALUES (%s, %s, %s, %s, %s, NOW())
                """,
                (sales_order_id, product_id, order_qty, unit_price, line_total),
            )

    conn.commit()
    print(
        f"Inserted order {sales_order_id} with {item_count} items; total_due={total_due}"
    )


def run():
    conn = connect_with_retry()
    while True:
        try:
            insert_order(conn)
            time.sleep(random.uniform(SLEEP_MIN, SLEEP_MAX))
        except OperationalError as exc:
            print(f"Connection dropped, reconnecting: {exc}")
            try:
                conn.close()
            except Exception:
                pass
            conn = connect_with_retry()
        except Exception as exc:
            print(f"Insert failed, rolling back transaction: {exc}")
            conn.rollback()
            time.sleep(1)


if __name__ == "__main__":
    run()
