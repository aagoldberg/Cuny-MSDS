DROP TABLE IF EXISTS holders;
DROP TABLE IF EXISTS holderGroups;

CREATE TABLE holderGroups (
holderGroupId int PRIMARY KEY, 
holderGroupName varchar NOT NULL
);

CREATE TABLE holders (
holderId int PRIMARY KEY,
holderName varchar NOT NULL,
holderGroupId int REFERENCES holderGroups(holderGroupId)
);

DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
roomId int PRIMARY KEY,
room varchar NOT NULL
);

DROP TABLE IF EXISTS holderRoomBridge;
CREATE TABLE holderRoomBridge (
holderGroupId int NOT NULL,
roomId int NOT NULL
);

INSERT INTO holderGroups (holderGroupId, holderGroupName)
	VALUES	(1, 'I.T.'),
		(2, 'Sales'),
		(3, 'Administration'),
		(4, 'Operations');

INSERT INTO holders (holderId, holderName, holderGroupId)
	VALUES	(1, 'Modesto', 1),
		(2, 'Ayine', 1),
		(3, 'Christopher', 2),
		(4, 'Cheong Woo', 2),
		(5, 'Saulat', 3),
		(6, 'Heidy', NULL);

INSERT INTO rooms (roomId, room)
	VALUES	(1, '101'),
		(2, '102'),
		(3, 'Auditorium A'),
		(4, 'Auditorium B');
		
INSERT INTO holderRoomBridge (holderGroupId, roomId)
	VALUES	(1, 1),
		(1, 2),
		(2, 2),
		(2, 3);

--All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
SELECT g.holderGroupName as groups, h.holderName as users
FROM holderGroups g
LEFT JOIN holders h
ON g.holderGroupId = h.holderGroupId;

--All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.
SELECT r.room as rooms, g.holderGroupName as groups
FROM holderRoomBridge b
LEFT JOIN holderGroups g ON b.holderGroupId = g.holderGroupId
RIGHT JOIN rooms r ON r.roomId = b.roomId;

--A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room.
SELECT h.holderName as users, g.holderGroupName as groups, r.room as rooms
FROM holderRoomBridge b
RIGHT JOIN holderGroups g ON b.holderGroupId = g.holderGroupId
LEFT JOIN rooms r ON r.roomId = b.roomId
RIGHT JOIN holders h ON g.holderGroupId = h.holderGroupId
ORDER BY users, groups, rooms;