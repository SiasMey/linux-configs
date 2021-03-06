---------------
--  Options  --
---------------

options.timeout = 120
options.subscribe = true


----------------
--  Accounts  --
----------------


-----------------
--  Mailboxes  --
-----------------

---------------------
-- archive service --
---------------------

month = os.date("%m") - 1;
year = os.date("%Y");

if (month == 0) then
  month = 1;
  year = year - 1;
end

archive = "Archive/".. year .. "/" .. month;

result = account.INBOX:is_older(30)
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account[archive], result)

--DD mail
result = account.INBOX:contain_from('@dialdynamics.co.za')
account.INBOX:move_messages(account['DialDynamics'], result)

result = account.INBOX:contain_from('root@affinityza.co.za')
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account['Affinity reports'], result)

result = account.INBOX:contain_field('List-Id','Tigermouse development mailing list <tigermouse-devel.lists.sourceforge.net>') 
account.INBOX:move_messages(account['tigermouse'], result)

result = account.INBOX:contain_field('List-Id','qooxdoo Development <qooxdoo-devel.lists.sourceforge.net>') 
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account['Qooxdoo list'], result)

result = account.INBOX:contain_field('List-Id','Maia Mailguard users list <maia-users.renaissoft.com>') 
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account['Maia list'], result)

result = account.INBOX:contain_field('List-Id','Asterisk Tech <tech.asterisk.org.za>') 
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account['Asterisk'], result)
