# Yashulan
Transplant Yashulan bot @yashulan

## start(backend)
`
$ carton exec -- plackup -Ilib -R ./lib --access-log /dev/null -p 5000 -a ./script/yashulan-server
`
## appendix (CentOS time adjustment)
```
$ sudo service ntpd start    
$ ntpq -p 
```
