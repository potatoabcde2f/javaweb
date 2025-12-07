package com.petadopt.entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class AdoptionApplication implements Serializable {
    private Integer applicationId;
    private Integer petId;
    private Integer contactId;
    private Timestamp applicationDate;
    private String status;
    /* 关联对象 */
    private Pet pet;
    private ContactPerson contactPerson;

    public Integer getApplicationId() { 
        return applicationId; 
    }
    
    public void setApplicationId(Integer applicationId) { 
        this.applicationId = applicationId; 
    }
    
    public Integer getPetId() { 
        return petId; 
    }
    
    public void setPetId(Integer petId) { 
        this.petId = petId; 
    }
    
    public Integer getContactId() { 
        return contactId; 
    }
    
    public void setContactId(Integer contactId) { 
        this.contactId = contactId; 
    }
    
    public Timestamp getApplicationDate() { 
        return applicationDate; 
    }
    
    public void setApplicationDate(Timestamp applicationDate) { 
        this.applicationDate = applicationDate; 
    }
    
    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }
    
    public Pet getPet() { 
        return pet; 
    }
    
    public void setPet(Pet pet) { 
        this.pet = pet; 
    }
    
    public ContactPerson getContactPerson() { 
        return contactPerson; 
    }
    
    public void setContactPerson(ContactPerson contactPerson) { 
        this.contactPerson = contactPerson; 
    }
}