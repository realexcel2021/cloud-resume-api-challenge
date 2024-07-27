resource "aws_dynamodb_table" "this" {
  name           = var.dynamodb_table_name
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "resume"

  attribute {
    name = "resume"
    type = "S"
  }
}

########################################
# insert table items
resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
    "resume": {
      "S": "sheriff_resume"
    },
    "basics": {
      "M": {
        "location": {
          "M": {
            "address": {
              "S": "No. 24 Kabido Street Kaduna"
            },
            "city": {
              "S": "Kaduna State"
            },
            "countryCode": {
              "S": "NG"
            },
            "postalCode": {
              "S": "800246"
            },
            "region": {
              "S": "KAD"
            }
          }
        },
        "name": {
          "S": "Sheriff Joe"
        },
        "phone": {
          "S": "+2349159381912"
        },
        "summary": {
          "S": "A young passionate devops engineer eager to learn new technologies and concepts related to the cloud. Experience working in devops, cloud and implementing concepts such as gitops, CICD, monitoring and logging."
        }
        
      }
    },
   
    "workExperience": {
        "M" : {
          "HostspaceCloud" : {
            "M": {
                "company": {
                  "S": "Hostspace Cloud"
                },
                "position": {
                  "S": "DevOps Engineer"
                },
                "startDate": {
                  "S": "2023-10-1"
                },
                "endDate": {
                  "S": "till-date"
                }
              }
          },
          "WAARON_LCC" : {
            "M" : {
                "company": {
                    "S": "WAARON LLC"
                  },
                  "position": {
                    "S": "Cloud Infrastruture Engineer"
                  },
                  "startDate": {
                    "S": "2023-10-1"
                  },
                  "endDate": {
                    "S": "till-date"
                  }   
            }
          }
        }
    }

    }
  
  
ITEM
}