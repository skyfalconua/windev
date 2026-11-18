git-copy-ssh() {
  mkdir -p ~/.ssh && cp -af "$(cygpath -u "$USERPROFILE/.ssh")/." ~/.ssh/
}
