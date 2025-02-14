{% macro last_ever_join_clause(i=none) %}
(
    {{ dbt_activity_schema.generate_stream_alias(i) }}.{{ dbt_activity_schema.columns().activity_repeated_at }} is null
)
{% endmacro %}

{% macro last_ever() %}

{% do return(namespace(
    name="last_ever",
    aggregation_func="min",
    join_clause=dbt_activity_schema.last_ever_join_clause,
    where_clause=dbt_activity_schema.last_ever_join_clause()
)) %}

{% endmacro %}
