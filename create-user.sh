#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if the username parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <new_username>"
  exit 1
fi

# Assign the parameter to a variable
NEW_USER_ID=$1
NEW_USER=$2
NEW_GROUP_ID=$3
NEW_GROUP=$4

# Create the new user and its home directory
addgroup -g $NEW_GROUP_ID $NEW_GROUP
useradd -m $NEW_USER -g $NEW_GROUP_ID

# Check if the user was created successfully
if [ $? -ne 0 ]; then
  echo "Failed to create user $NEW_USER"
  exit 1
fi

# Copy contents from /root to the new user's home directory
cp -r /root/* /home/$NEW_USER/

# Copy hidden files as well
cp -r /root/.* /home/$NEW_USER/ 2>/dev/null

# Change ownership of the copied files to the new user
chown -R $NEW_USER:$NEW_GROUP /home/$NEW_USER

echo "User $NEW_USER created"
