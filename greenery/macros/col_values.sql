   
{% macro col_values(table, column) %}
    {%- set query_sql %}
    SELECT DISTINCT {{column}} FROM {{table}}
    {% endset %}

    {%- if execute %}
        {% set tot_col_values =  run_query(query_sql).columns[0].values()%}

        {%- for col_val in tot_col_values %}
            SUM(CASE WHEN {{column}} = '{{col_val}}' THEN 1 ELSE 0 END) AS is_{{col_val}}
            {%- if not loop.last %},{% endif -%}
        {% endfor %}
    {% else %}

    {% endif -%}


{% endmacro %}