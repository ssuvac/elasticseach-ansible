env        := hosts
vault_password   := environment/dev/vars/vault_pass.txt
HOST_GROUP_FILE = environment/dev/vars/$(host_group).yaml
VAULT_VAR_FILE = environment/dev/vars/vault_variables.yml
MAIN_VAR := environment/dev/vars/all.yml

deploy_mongodb_cluster:
	@env=$(env) ansible-playbook --inventory-file="$(env)" playbooks/"$(host_group).yml" --vault-password-file="$(vault_password)" --limit $(host_group) --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(VAULT_VAR_FILE)" --extra-vars="@$(MAIN_VAR)" -kK

es_install:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=elastic-install --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

deploy_es_cluster_single_node:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=elastic-single-node --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

deploy_es_cluster:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=elastic-cluster-no-pass --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

es_conf_user:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=es-create-user --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

es_conf_https:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=es-https --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

conf_kibana:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=kibana-conf --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

kibana_install:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=kibana-install --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

deploy_kibana_conf_with_user:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=kibana-with-user --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

deploy_kibana_conf_no_user:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=kibana-no-user --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

test:
	ansible-playbook --inventory-file="$(env)" playbooks/es-cluster.yml --limit $(host_group) -t=test --vault-password-file="$(vault_password)" --extra-vars="@$(HOST_GROUP_FILE)" --extra-vars="@$(MAIN_VAR)" --extra-vars="@$(VAULT_VAR_FILE)"

