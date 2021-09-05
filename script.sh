echo "Reset Machine-ID"
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

echo "Reset Cloud-Init"
cloud-init clean -s -l

# https://kb.vmware.com/s/article/59687
touch /etc/cloud/cloud-init.disabled
