DELETE FROM thread t  WHERE t.dtmmodified <= UNIX_TIMESTAMP() - 14*24*60*60;  
UPDATE thread t SET t.remote = CONCAT(REGEXP_SUBSTR(t.remote, "(^[0-9]{1,3}.[0-9]{1,3})", 1, 1), ".?") WHERE t.dtmmodified <= UNIX_TIMESTAMP() - 7*24*60*60;
SELECT COUNT(*) FROM thread;