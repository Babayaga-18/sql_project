##########################Creating database named nba_stats###################################

create database NBA_stats;
Use NBA_stats;

#################################Creating table teams################################ 
create table teams
( 
Team_id int primary key,
Team_name varchar(20),
Team_city varchar(20),
coach_id int,
foreign key (coach_id) references coaches (coach_id)
);

#############################Creating table players################################
create table players 
(
player_id int primary key,
first_name varchar(20),
last_name varchar(20),
player_age int,
player_height int,
player_team varchar(50),
team_id int ,
foreign key (team_id) references teams (Team_id)  on update cascade on delete cascade

);
alter table players
drop column player_team;
select * from players;
###############################Creating table stats###############################
create table stats 
(
rebounds_pergame int,
points_pergame int,
field_goal_percentage int,
assist_pergame int,
player_id int,
foreign key (player_id) references players (player_id) on update cascade on delete cascade
);
###############################Creating table Coaches###############################
create table coaches
(
coach_id int primary key,
coach_name varchar(15),
team_id int
);
###############################Creating table team_stats###############################
create table team_stats
(
team_id int,
games_played int,
wins int,
losses int,
foreign key (team_id) references teams (Team_id)
);
############################Inserting data in table teams###########################
insert into teams
(Team_id,Team_name,Team_city,coach_id)
values
        ('1','GOLDEN STATE','CLIFORNIA',1),
		('2','LA LAKERS','LOS ANGELES',6),
		('3','LA CLIPPERS','LOS ANGELES',7),
		('4','KINGS','SACROMANTO',9),
		('5','JAZZ','UTHA',10),
		('6','MAGIC','ORLANDO',5),
		('7','THUNDER','OKC',4),
		('8','SUNS','PHIONIX',3),
		('9','CELTICS','BOSTON',2),
		('10','HEAT','MIAMI',8);

SELECT *FROM teams;
use nba_stats;
DROP table players;
##############################Inserting data in table Coaches#################################
insert into coaches
(coach_id, coach_name, team_id)
values
		(1,"Steve Kerr",1),
        (2,"Gregg Popovich",2),
        (3,"Erik Spoelstra",3),
        (4,"Doc Rivers",4),
        (5,"Will Hardy",5),
        (6,"JJ Redrick",6),
        (7,"Tyronn Lue",7),
        (8,"Joe Mazulla",8),
        (9,"Phil Jackson",9),
        (10,"Ime Udoka",10);
        

##############################Inserting data in table teams#################################
INSERT INTO players
(player_id,first_name,last_name,player_age,player_height,team_id)
VALUES
		(001,"Lebron","James",39,212,2),
        (002,"Stephen","Curry",35,193,1),
        (003,"Kevin","Durant",35,218,8),
        (004,"Devin","Booker",29,197,8),
        (005,"Klay","Thommosan",33,195,1),
        (006,"Ja","morant",22,196,4),
        (007,"Luka","Doncic",24,201,5),
        (008,"Anthony","Adwards",24,196,4),
        (009,"Rudy","Gobert",29,220,5),
        (010,"Chris","Paul",35,186,1),
        (011,"Kobe","Bryant",39,200,2),
        (012,"James","Harden",36,198,3),
        (013,"Russel","Westbrook",30,194,7),
        (014,"Paul","George",28,199,3),
        (015,"Cam","Jhonson",22,192,5),
        (016,"Wemby","",19,224,9),
        (017,"Jeremy","Scohan",23,198,9),
        (018,"Joel","Embiid",27,205,10),
        (019,"Nikola","Jokic",29,210,5),
        (020,"Antohony","Davis",29,211,2),
        (021,"Andre","",39,190,7),
        (022,"Jason","Tatum",25,200,9),
        (023,"Jimmy","Butller",29,195,10),
        (024,"Bam","Adabayo",26,198,10),
        (025,"J","cole",28,188,6),
        (026,"Drake","",32,182,6),
        (027,"Jordan","Poole",26,196,8),
        (028,"Jonathan","Kuminga",20,199,7),
        (029,"Mosses","Moody",20,190,4),
        (030,"Lemello","Ball",21,196,5);
SELECT * FROM players;

#####################Inserting data in table stats##############################
INSERT INTO stats
(rebounds_pergame,points_pergame,field_goal_percentage,assist_pergame,player_id)
values
(11,25,32,5,001),(5,30,40,6,002),(12,20,36,4,003),(05,18,29,6,004),(06,10,30,8,005),(07,26,37,8,006),
(07,7,20,7,007),(03,18,28,5,008),(09,19,37,3,009),(09,15,20,1,010),(12,21,38,6,011),(05,28,39,9,012),(11,23,30,8,013),(12,17,35,6,014),(08,30,33,9,015),(10,20,32,6,017),(07,28,32,11,018),
(07,33,37,5,019),(08,11,35,6,020),(09,12,30,6,021),(07,19,29,7,022),(11,18,38,5,023),(15,16,31,9,024),(09,23,38,7,025),(13,27,41,8,026),(16,18,29,11,027),(14,30,33,4,028),(10,15,31,11,029),
(05,32,41,5,030);
select * from stats;
use nba_stats;
select * from players;
create table ratings(
rank_id varchar(20),
rank_offensive int,
rank_defensive int,
foreign key (rank_id) references teams(Team_name) on update cascade on delete cascade
);
insert into team_stats
(team_id, games_played, wins, losses)
values
(1,20,13,7),(2,18,9,9),(3,20,10,10),(4,19,8,11),(5,18,17,1),
(6,19,14,5),(7,20,12,8),(8,18,9,9),(9,19,7,12),(10,20,5,15);
SELECT * FROM team_stats;

#########################################################SQL QUERIES###############################################
use nba_stats;
select max(player_age),avg(player_age),min(player_age),sum(player_age) from players;

select * from players where first_name like "_a%";

select * from players where player_age = 24;

#### second highest age of a player using subqurey #####
select first_name,last_name,player_age from players 
where player_age = (select max(player_age) from players where player_age < (select max(player_age) from players));

#### second highest age of a player using offset and limit #####
select distinct player_age from players
order by player_age desc
limit 1 offset 1;

#### age ranking of  players using cte and window functions #####

with age_ranking as(
select first_name, last_name, player_age,
row_number() over(order by player_age desc) as ages from players
)
select first_name, last_name, player_age, ages from age_ranking;
#### Case statements #####
select first_name, last_name, player_age,player_height,
case
	when player_age<30 then player_height*1.05
	when player_age>=30 then player_height*1.02
end as new_height
from players;

######## Joins to get other insights #######
select  team_name,coach_name, team_city from coaches
join teams on coaches.team_id = teams.team_id;

### top 5 player with highest points per game ###
select points_pergame, first_name, last_name,
row_number() over (order by points_pergame desc) as top_players
from players
join stats on players.player_id = stats.player_id
limit 5;

### top 5 player with highest assist per game ###
select assist_pergame, first_name, last_name,
row_number() over (order by assist_pergame desc) as top_players
from players
join stats on players.player_id = stats.player_id
limit 5;

### team with most wins ###
select * from teams
join team_stats on teams.Team_id = team_stats.team_id
where team_stats.wins = (select max(wins)from team_stats)
;
### team with most losses ###
select * from teams
join team_stats on teams.Team_id = team_stats.team_id
where team_stats.losses = (select max(losses) from team_stats);

















