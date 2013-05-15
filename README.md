# Sysverify #
pdsh based node checking script for HPC machines, written by Karl Vollmer 
karl.vollmer@gmail.com for Dalhousie University

### Installation Quick'n'Dirty ###

```
  cp base.cfg.dist base.cfg
  vi base.cfg
  cp example.cfg NAME.cfg
  vi NAME.cfg
  cp example.pre.tests NAME.pre.tests 
  cp example.tests NAME.tests
  vi NAME.tests
  cp example.nodes NAME.nodes
  vi NAME.nodes
```

## Add to Cron

```
  /opt/sysverify/sysverify -c CLUSTERNAME
``` 
