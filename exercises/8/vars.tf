variable "list1" {
  type = "list"
  default = [
    "val12456ybvfdertyhjn",
    "val2",
    "val3"
  ]
}

variable "list2" {
  type = "list"
  default = [
    "val12",
    "val22",
    "val32"
  ]
}

variable "map1" {
  type = "map"
  default = {
    "key1" = "val1",
    "key2" = "val2",
    "key3" = "val3",
    "key4" = "val4",
  }
}

variable "map2" {
  type = "map"
  default = {
    "key12" = "val12",
    "key22" = "val22",
    "key32" = "val32",
    "key42" = "val42",
  }
}

variable "string1" {
  type = "string"
  default = "string1"
}

variable "string2" {
  type = "string"
  default = "stRINg2"
}