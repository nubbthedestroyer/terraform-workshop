output "list_element" {
  value = "${element(var.list1, 0)}"
}

resource "aws_s3_bucket" "user_bucket" {
  count = "${length(var.list1)}"
  bucket_prefix = "mlucas-${element(var.list1, count.index)}-"
}

output "find_list_index" {
  value = "${index(var.list2, "val22")}"
}

output "list_length" {
  value = "${length(var.list2)}"
}