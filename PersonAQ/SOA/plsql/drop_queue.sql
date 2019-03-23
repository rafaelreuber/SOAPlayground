begin
 DBMS_AQADM.DROP_QUEUE(queue_name => 'si.person_aq');
 DBMS_AQADM.DROP_QUEUE_TABLE(queue_table => 'si.person_qt');
end;