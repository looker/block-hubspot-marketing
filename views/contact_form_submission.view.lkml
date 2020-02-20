view: contact_form_submission {
  sql_table_name: @{DATASET_NAME}.CONTACT_FORM_SUBMISSION ;;

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(CAST(${contact_id} AS STRING), CAST(${conversion_id} AS STRING)) ;;
  }

  dimension: contact_id {
    type: number
    hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: conversion_id {
    type: number
    sql: ${TABLE}.conversion_id ;;
    hidden: yes
  }

  dimension: form_id {
    type: number
    sql: ${TABLE}.form_id ;;
    hidden: yes
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: portal_id {
    type: number
    sql: ${TABLE}.portal_id ;;
    hidden: yes
  }

  # dimension: timestamp {
  #   type: string
  #   sql: ${TABLE}.timestamp ;;
  # }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      date,
      week,
      hour_of_day,
      day_of_week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: PARSE_TIMESTAMP('%m-%d-%YT%H:%M:%S', ${TABLE}.timestamp) ;;
    datatype: datetime
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [contact_id, timestamp_raw]
  }

  measure: conversions {
    type: count_distinct
    sql: ${conversion_id} ;;
  }
}
