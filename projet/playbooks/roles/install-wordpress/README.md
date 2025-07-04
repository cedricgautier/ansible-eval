# Install WordPress Role

This Ansible role automates the installation of WordPress with MariaDB on Ubuntu and Rocky Linux systems in containerized environments.

## Description

This role converts a shell script into a proper, maintainable, and idempotent Ansible role that:
- Installs and configures Apache web server
- Installs and configures MariaDB database server
- Downloads and installs WordPress
- Creates secure database configuration
- Configures Apache virtual hosts
- Sets up proper file permissions

## Requirements

- Ansible 2.9 or higher
- Target systems: Ubuntu 20.04+, Rocky Linux 8+
- Python MySQL library (PyMySQL) on target hosts
- Root or sudo privileges on target hosts

## Supported Platforms

- Ubuntu 20.04 (Focal)
- Ubuntu 22.04 (Jammy)
- Rocky Linux 8
- Rocky Linux 9

## Role Variables

### Database Configuration
```yaml
wordpress_db_name: "wordpress"              # WordPress database name
wordpress_db_user: "example"                # WordPress database user
wordpress_db_password: "P@ssw0rd"           # WordPress database password
wordpress_db_root_password: "P@ssw0rd"      # MariaDB root password
wordpress_db_host: "localhost"              # Database host
```

### WordPress Configuration
```yaml
wordpress_version: "latest"                 # WordPress version to install
wordpress_path: "/var/www/html"             # WordPress installation path
wordpress_url: "https://wordpress.org/latest.zip"  # WordPress download URL
```

### Apache Configuration
```yaml
apache_document_root: "/var/www/html"       # Apache document root
apache_server_admin: "admin@localhost"     # Apache server admin email
apache_site_name: "wordpress"              # Apache site configuration name
```

### Package Lists
The role automatically selects appropriate packages based on the target OS:
- **Debian/Ubuntu**: apache2, php, libapache2-mod-php, php-mysql, mariadb-server, wget, unzip
- **RedHat/Rocky**: httpd, php, php-mysqlnd, mariadb-server, wget, unzip

## Dependencies

None. This role is self-contained.

## Example Playbook

### Basic Usage
```yaml
- hosts: webservers
  become: yes
  roles:
    - install-wordpress
```

### With Custom Variables
```yaml
- hosts: webservers
  become: yes
  vars:
    wordpress_db_name: "my_blog"
    wordpress_db_user: "blog_user"
    wordpress_db_password: "SecurePassword123!"
    wordpress_db_root_password: "RootPassword123!"
    apache_server_admin: "admin@example.com"
  roles:
    - install-wordpress
```

### Complete Example
```yaml
---
- name: Install WordPress on web servers
  hosts: webservers
  become: yes
  vars:
    wordpress_db_name: "production_blog"
    wordpress_db_user: "wp_user"
    wordpress_db_password: "{{ vault_wp_password }}"
    wordpress_db_root_password: "{{ vault_root_password }}"
    apache_server_admin: "webmaster@company.com"
  
  roles:
    - install-wordpress
  
  post_tasks:
    - name: Display WordPress URL
      debug:
        msg: "WordPress is available at http://{{ ansible_default_ipv4.address }}"
```

## Usage in Containers

This role is designed to work in containerized environments. For proper operation:

### MariaDB in Containers
```bash
# Start MariaDB in background
mysqld_safe --datadir=/var/lib/mysql &
```

### Apache in Containers
```bash
# Ubuntu containers
service apache2 start

# Rocky Linux containers
/usr/sbin/httpd -DFOREGROUND
```

## Security Considerations

- **Change default passwords**: Always override default database passwords in production
- **Use Ansible Vault**: Store sensitive variables in encrypted vaults
- **File permissions**: Role sets appropriate permissions for WordPress files
- **Database security**: Removes anonymous users and test databases automatically

## Testing

A test playbook is included in the `tests/` directory:

```bash
# Run tests
ansible-playbook -i tests/inventory tests/test.yml
```

## File Structure

```
install-wordpress/
├── README.md
├── defaults/main.yml          # Default variables
├── files/                     # Static files
├── handlers/main.yml          # Service handlers
├── meta/main.yml             # Role metadata
├── tasks/
│   ├── main.yml              # Main task orchestration
│   ├── install_packages.yml  # Package installation
│   ├── database.yml          # Database setup
│   ├── wordpress.yml         # WordPress installation
│   └── apache.yml            # Apache configuration
├── templates/
│   ├── wp-config.php.j2      # WordPress configuration
│   ├── wordpress-debian.conf.j2  # Apache vhost (Debian)
│   └── wordpress-redhat.conf.j2  # Apache vhost (RedHat)
├── tests/
│   ├── inventory             # Test inventory
│   └── test.yml              # Test playbook
└── vars/main.yml             # Role variables
```

## Handlers

The role includes handlers for:
- **restart apache**: Restarts Apache service when configuration changes
- **reload apache**: Reloads Apache configuration
- **restart mysql**: Restarts MariaDB service

## Idempotency

This role is fully idempotent and can be run multiple times safely without causing issues.

## License

MIT

## Author Information

**Cedric Gautier**  
Junior DevOps Engineer  
Web Hosting Company

Created as part of automated deployment automation project to replace manual shell scripts with maintainable Ansible roles.
