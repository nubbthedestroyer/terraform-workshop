output "list_element" {
  value = "${element(var.list1, 0)}"
}

output "find_list_index" {
  value = "${index(var.list2, "val22")}"
}

output "list_length" {
  value = "${length(var.list2)}"
}