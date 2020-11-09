# svn-ssh
Docker image based on Alpine Linux with subversion, openssh-server and openssh-sftp-server

## Experimental. Not for production use

## SSH username
*svnuser*

## Working directory
*/svn*

## Environment variables
REPO (default = repo)
 
SSHUSER_PUB_KEY (required, default = N/A)

TZ (default=UTC)

## Files
authorized_keys.example
Sample file with configuration for tunneling svn users
