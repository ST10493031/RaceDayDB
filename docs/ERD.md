# RaceDay Database - Entity Relationship Diagram

## Database Schema Overview

```
┌─────────────┐         ┌─────────────┐         ┌──────────────┐
│   users     │         │   races     │         │ participants │
├─────────────┤         ├─────────────┤         ├──────────────┤
│ id (PK)     │         │ id (PK)     │         │ id (PK)      │
│ username    │         │ name        │         │ user_id (FK) │
│ email       │         │ date        │         │ race_id (FK) │
│ password    │         │ location    │         │ bib_number   │
│ created_at  │         │ created_at  │         │ finish_time  │
└─────────────┘         └─────────────┘         │ status       │
       │                       │                 │ created_at   │
       │                       │                 └──────────────┘
       └───────────────────────┴──────────────────────────────┘
              One-to-Many Relationships
```

## Entities

### users
- Stores user account information
- Primary Key: `id`
- Unique Constraints: `username`, `email`

### races
- Stores race event information
- Primary Key: `id`
- Contains race metadata (name, date, location)

### participants
- Links users to races (junction table)
- Primary Key: `id`
- Foreign Keys: `user_id` (references users), `race_id` (references races)
- Stores participant-specific race data (bib number, finish time, status)

## Relationships

- **users → participants**: One-to-Many (one user can participate in many races)
- **races → participants**: One-to-Many (one race can have many participants)
