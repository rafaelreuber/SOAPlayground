declare
    queue_option     dbms_aq.enqueue_options_t;
    msg_properties   dbms_aq.message_properties_t;
    person          si.person_type;
    msg_id           varchar(50);
    
    type array_t is varray(3) of varchar2(10);
    age_type_array array_t := array_t('YOUNG', 'MIDDLE', 'OLD');
    
    v_count number(20) := 0;
    
    v_age varchar2(10);
    
begin 

    while v_count <= 100
    loop
    
        v_age := age_type_array(round(dbms_random.value(1,3)));
        
        person := si.person_type( 
             1, 
             DBMS_RANDOM.string('x',20),
             v_age,
             to_date(sysdate)
        );
        
        if v_age = 'OLD' 
        then
            msg_properties.priority := 3;
        elsif v_age = 'MIDDLE'
        then
            msg_properties.priority := 2;
        elsif v_age = 'YOUNG'
        then
            msg_properties.priority := 1;
        end if;
                                 
        dbms_aq.enqueue(
            queue_name => 'SI.PERSON_AQ', 
            enqueue_options => queue_option, 
            message_properties => msg_properties, 
            payload => person, 
            msgid => msg_id);
            
        v_count := v_count +1;
        commit;
    end loop;
end;


