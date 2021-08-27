module "bucket-extra" {
        source = "../modules/extra-bucket/"
        project_id = var.project_id
	repo_path = var.repo_path_input		
}

#singel schema
module "schema" {
        source = "../modules/schema/"
        schema_name = "gaurav"
	schema_type = "AVRO"
}

#3 pubsub as per topic_name length
module "pubsub" {
	source = "../modules/pubsub/"
	project_id = var.project_id
	#schema_name = module.schema.schema_name
	#schema_type = module.schema.schema_type
	topic_name = var.topic_name
}

#multiple subscription as per topic name
module "subscription" {
        source = "../modules/subscription/"
        topic_name = module.pubsub.name
}

#function service account
module "service_account_cf_input" {
        source = "../modules/service_account/"
        project_id = var.project_id
	display_name = "cloud function input"
	description = "cloud function input"
	service_account_name = "gaurav"
	role_access = ["roles/pubsub.publisher"]
}


module "bucket" {
        source = "../modules/cloud_storage/"
        project_id = var.project_id
        bucket_name = var.raw_bucket_name_one
        bucket_region = var.raw_bucket_region_one
        service_account = module.service_account_cf_input.service_account
        bucket_role = ["roles/storage.objectCreator"]
}


module "cloud_function_input_1" {
        source = "../modules/cloud_function_input/"
        project_id = var.cf_project_id		
        bucket_name = module.raw_bucket_1.bucket_name
        cf_region = var.cf_input_region_one
        service_account = module.service_account_cf_input.service_account
        function_name = var.cf_input_name_one
	function_entry_point = "gaurav"
	environment_variables = {"key": var.topic_name[0], "key_two": var.cf_project_id}
}


