-- Data Cleaning

select *
from layoffs;

-- 1.Remove Duplicates
-- 2.Standardize the Data
-- 3.Null Values or Blank values
-- 4.Remove Any Columns


CREATE table layoffs_staging
like layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;


with duplicate_cte as
(
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, date,stage
,country,funds_raised_millions) as row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num >1;



create table layoffs_staging2 as
Select * ,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions
order by company) as row_num
from layoffs_staging;


delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;


-- Standarding the Data


select company,trim(company)
from layoffs_staging2;