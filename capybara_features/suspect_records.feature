Feature: Suspect records

  As an admin
  I want to be able to mark suspect records as investigated
  To keep track of flagged records
  
  Background:
  
  Given I am logged in as an admin
  And the following children exist in the system:
     | name   | unique_id  | flag     | flag_message      | investigated |
     | Steve  | steve_uid  | true     | steve is dodgy    | false        |
     | Bob    | bob_uid    | true     | bob is dodgy      | false        |
     | Dave   | dave_uid   | true     | dave is dodgy     | true         |
     | George | george_uid | false    | nil               | false        |
     
  Scenario: Admin user should see a link on the home page with the details of how many suspect records need attention
  When I am on the home page
  Then I should see "2 Records need Attention"

  Scenario: Admin user should only see flagged children which have not been investigated
  When I am on the Suspect Records page
  Then I should see "Steve"
  And I should see "Bob"
  And I should not see "Dave"
  And I should not see "George"
  
  Scenario: Admin should be able to mark suspect record as investigated
  When I am on the Suspect Records page
  And I follow "Steve"
  Then I should see "Mark record as Investigated"
  
  Scenario: When an admin user marks a flagged record as investigated it should no longer appear on the suspect record page
  When I am on the Suspect Records page
  And I follow "Steve"
  And I mark "Steve" as investigated with the following details:
    """
    I wouldn't worry about this guy
    """
  And I am on the Suspect Records page
  Then I should not see "Steve"
  
  Scenario: Admin should be able to mark investigated record as not investigated
  When I am on the children listing page
  And I follow "Dave"
  Then I should see "Mark as Not Investigated"
  
  Scenario: When an admin user marks an investigated record as not investigated it should appear on the suspect record page
  When I am on the children listing page
  And I follow "Dave"
  And I mark "Dave" as not investigated with the following details:
    """
    I don't know what's going on with this record
    """  
  And I am on the Suspect Records page
  Then I should see "Dave"
  
  Scenario: When a record is not flagged admin should not be able to mark as investigated or not investigated
  When I am on the children listing page
  And I follow "George"
  Then I should not see "Mark record as Investigated"
  And I should not see "Mark as Not Investigated"
  
  Scenario: When I mark a record as investigated the change log should display a single entry for the change
  When I am on the Suspect Records page
  And I follow "Steve"
  And I mark "Steve" as investigated with the following details:
    """
    I wouldn't worry about this guy
    """
  And I follow "View the change log"
  Then I should see "Record was marked as Investigated by admin because: I wouldn't worry about this guy"
  
  Scenario: When I mark a record as not investigated the change log should display a single entry for the change
  When I am on the children listing page
  And I follow "Dave"
  And I mark "Dave" as not investigated with the following details:
    """
    I don't know what's going on with this record
    """
  And I follow "View the change log"
  Then I should see "Record was marked as Not Investigated by admin because: I don't know what's going on with this record"  