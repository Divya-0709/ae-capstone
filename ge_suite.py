import great_expectations as gx

context = gx.get_context()

datasource = context.data_sources.add_sql(
    name="bigquery_datasource",
    connection_string="bigquery://ae-capstone-2025/staging_marts",
)

asset = datasource.add_table_asset(
    name="fct_orders",
    table_name="fct_orders",
)

batch_definition = asset.add_batch_definition_whole_table("full_table")
batch = batch_definition.get_batch()

suite = context.suites.add(
    gx.ExpectationSuite(name="fct_orders_suite")
)

expectations = [
    gx.expectations.ExpectColumnValuesToNotBeNull(column="order_id"),
    gx.expectations.ExpectColumnValuesToNotBeNull(column="customer_id"),
    gx.expectations.ExpectColumnValuesToNotBeNull(column="purchase_date"),
    gx.expectations.ExpectColumnValuesToBeUnique(column="order_id"),
    gx.expectations.ExpectColumnValuesToBeInSet(
        column="status",
        value_set=["delivered","shipped","canceled","processing",
                   "unavailable","invoiced","approved","created"]
    ),
    gx.expectations.ExpectColumnValuesToBeInSet(
        column="payment_type",
        value_set=["credit_card","boleto","voucher","debit_card","not_defined"]
    ),
    gx.expectations.ExpectColumnValuesToBeBetween(
        column="order_value", min_value=0, max_value=100000
    ),
]

for exp in expectations:
    suite.add_expectation(exp)

validation_definition = context.validation_definitions.add(
    gx.ValidationDefinition(
        name="fct_orders_validation",
        data=batch_definition,
        suite=suite,
    )
)

results = validation_definition.run()
print("Validation success:", results.success)

context.open_data_docs()