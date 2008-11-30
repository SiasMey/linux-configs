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

--affinity mail
result = account.INBOX:is_unseen() *
         account.INBOX:contain_from('@affinity.co.za')
account.INBOX:move_messages(account['Affinity'], result)

result = account.INBOX:is_unseen() *
         account.INBOX:contain_from('root@affinityza.co.za')
account.INBOX:mark_seen(result)
account.INBOX:move_messages(account['Cron at Affinity'], result)

--glug lists
result = account.INBOX:contain_subject('[GLUG-chat]') 
account.INBOX:move_messages(account['lists/glug/chat'], result)

result = account.INBOX:contain_subject('[GLUG-tech]') 
account.INBOX:move_messages(account['lists/glug/tech'], result)

--clug lists
result = account.INBOX:contain_field('List-Id','Announcements of Meetings and Events <clug-announce.clug.org.za>') 
account.INBOX:move_messages(account['lists/clug/announce'], result)

result = account.INBOX:contain_field('List-Id','OSS-Related Technology Discussions <clug-chat.clug.org.za>') 
account.INBOX:move_messages(account['lists/clug/chat'], result)

result = account.INBOX:contain_field('List-Id','OSS Technical Questions and Answers <clug-tech.clug.org.za>') 
account.INBOX:move_messages(account['lists/clug/tech'], result)

--ubuntu lists
result = account.INBOX:contain_field('List-Id','<ubuntu-users.lists.ubuntu.com>') 
account.INBOX:move_messages(account['lists/ubuntu/users'], result)

result = account.INBOX:contain_field('List-Id','Ubuntu laptop testing <laptop-testing-team.lists.ubuntu.com>') 
account.INBOX:move_messages(account['lists/ubuntu/laptop testing'], result)

result = account.INBOX:contain_field('List-Id','<free-software-laptop.lists.ubuntu.com>') 
account.INBOX:move_messages(account['lists/ubuntu/foss laptop'], result)

--freeswitch lists
result = account.INBOX:contain_field('List-Id','<freeswitch-users.lists.freeswitch.org>') 
account.INBOX:move_messages(account['lists/freeswitch/users'], result)

result = account.INBOX:contain_field('List-Id','<freeswitch-dev.lists.freeswitch.org>') 
account.INBOX:move_messages(account['lists/freeswitch/dev'], result)

--phpreports lists
result = account.INBOX:contain_field('List-Id','phpreports users discussion list <phpreports-users.lists.sourceforge.net>') 
account.INBOX:move_messages(account['lists/phpreports'], result)
