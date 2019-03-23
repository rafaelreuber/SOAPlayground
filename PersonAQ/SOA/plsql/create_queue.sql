-- Define message structure
CREATE OR REPLACE TYPE si.person_type AS OBJECT (
    ID NUMBER(4),
    NAME VARCHAR2(30),
    TYPE VARCHAR2(30),
    BIRTHDAY DATE
);
    

BEGIN  
    DBMS_AQADM.CREATE_QUEUE_TABLE(
            queue_table        => 'si.person_qt'
          , queue_payload_type => 'si.person_type'
          , sort_list          => 'PRIORITY,ENQ_TIME'
    );
    
    DBMS_AQADM.CREATE_QUEUE(queue_name => 'si.person_aq', 
    queue_table => 'si.person_qt');
    
    dbms_aqadm.start_queue (queue_name => 'SI.PERSON_AQ', enqueue => TRUE , dequeue => TRUE);
END;

