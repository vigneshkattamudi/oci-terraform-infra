resource "oci_monitoring_alarm" "adb_cpu_alarm" {
  compartment_id          = var.compartment_ocid
  display_name            = "ADB CPU Utilization Alarm"
  metric_compartment_id   = var.compartment_ocid
  namespace               = "oci_autonomous_database"
  query                   = "CpuUtilization[1m]{resourceId = \"${oci_database_autonomous_database.free_atp.id}\"}.mean() > ${var.cpu_alarm_threshold}"
  resolution              = "1m"
  severity                = "CRITICAL"
  is_enabled              = true
  destinations            = [var.ons_topic_id]
}

resource "oci_database_autonomous_database" "free_atp" {
  compartment_id            = var.compartment_ocid
  db_name                   = "MYATPDB"
  display_name              = "my-free-atp"
  admin_password            = var.admin_password
  cpu_core_count            = 1
  data_storage_size_in_tbs  = 1
  db_workload               = "OLTP"
  is_free_tier              = true
}