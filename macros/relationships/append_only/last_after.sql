{% macro last_after_join_clause(i) %}

{% set stream = dbt_activity_schema.generate_stream_alias %}
{% set columns = dbt_activity_schema.columns() %}

(
    {{ stream(i) }}.{{- columns.ts }} > {{ stream() }}.{{- columns.ts }}
    and {{ stream(i) }}.{{- columns.ts }} <= coalesce({{ stream() }}.{{- columns.activity_repeated_at }}, '2100-01-01'::timestamp)
)
{% endmacro %}

{% macro last_after() %}

{% do return(namespace(
    name="last_after",
    aggregation_func="max",
    join_clause=dbt_activity_schema.last_after_join_clause
)) %}

{% endmacro %}
