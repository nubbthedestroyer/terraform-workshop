output "map_lookup" {
  value = "${lookup(var.map1, "key1", "no_key" )}"
}

output "values" {
  value = "${values(var.map1)}"
}

output "zipmap" {
  value = "${zipmap(var.list1, var.list2)}"
}

output "keys" {
  value = "${keys(var.map1)}"
}

output "maps_merge" {
  value = "${merge(var.map1, var.map2)}"
}