CREATE TABLE `bilbutik` (
	`vehicle` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`plate` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`price` INT(11) NULL DEFAULT '5000'
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
