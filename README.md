
=== Sysverify ===

#### Installation Quick'n'Dirty ####

## Configure 

  cp base.cfg.dist base.cfg
  vi base.cfg
  cp example.cfg NAME.cfg
  vi NAME.cfg
  cp example.pre.tests NAME.pre.tests 
  cp example.tests NAME.tests
  vi NAME.tests
  cp example.nodes NAME.nodes
  vi NAME.nodes

## Add to Cron

  sysverify -c NAME
