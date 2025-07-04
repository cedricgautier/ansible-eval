# Automated Application Deployment

## Professional Context

You have just been hired as a junior DevOps in a web hosting company. Your first assignment is to automate the deployment of a WordPress site with a MariaDB database on Linux servers (Ubuntu and Rocky Linux) in a containerized environment.  
To ensure the quality and reproducibility of deployments, the technical team has chosen to use Ansible.  
A shell script is provided to you by a colleague. Your goal is to transform it into a proper, maintainable, and idempotent Ansible role, then publish it on Ansible Galaxy.

## Mission Objective

1. Create a complete Ansible role based on the [install_wordpress.sh](Install_wordpress.sh) script.

2. Ensure it works on both Ubuntu and Rocky Linux.

3. Organize the role in a reusable way, with:

   - Configurable variables  
   - Split files (handlers, tasks, vars, defaults, etc.)  
   - One or more handlers  
   - Conditions (`when`) and loops (`loop`) if necessary

4. Write a clear README explaining the role, variables, and execution.

5. Test your role via a sample playbook.

6. Publish the role on Ansible Galaxy.

## Evaluation Criteria

- Role structure  
- Script adaptation  
- Idempotence  
- Variables  
- Loops / Conditions  
- Handlers  
- Documentation  
- Galaxy publication  
- Functional test playbook  
- Code quality

## Expected Deliverables

- Send by email the link to the role on https://galaxy.ansible.com.

## Educational Tips

- Start by thoroughly understanding the steps in the script.  
- Test your role on at least one Debian container and one Rocky Linux container.  
- Pay attention to differences: apache2 vs httpd, apt vs dnf, systemctl vs service.  
- Use `notify` and handlers whenever you modify an Apache/MariaDB config.

## Things to Know

Start MariaDB in the background in a container:  
```bash
mysqld_safe --datadir=/var/lib/mysql &
```

Start Apache2 in an Ubuntu container:  
```bash
service apache2 start
```

Start httpd in a Rocky container:  
```bash
/usr/sbin/httpd -DFOREGROUND
```