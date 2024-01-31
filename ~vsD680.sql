--Select all fro the CovidDeaths table
select * 
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null;



--Select all fro the CovidVacc table
select * 
from PortfolioProject..CovidVaccinations
where continent is  not null ;

--Order by
select *
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
order by 3,4;

select * 
from PortfolioProject..CovidVaccinations 
where continent is  not null 
order by 3,4;




select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
order by 1,2;


--Total cases vs Total Deaths
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
order by 1,2;

--Total Deaths vs Tocal Cases where location is states
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where  location like '%states%' and total_deaths is not null
order by 1,2;

--Total cases vs population (shows percentage of population that got covid)
select location,date,total_cases,population,(total_cases/population)*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
order by 1,2;


--Total cases vs population where location is states(shows percentage of population in the US that got covid)
select location,date,total_cases,population,(total_cases/population)*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is  not null and total_deaths is not null
order by 1,2;

--Country with the highest infection rate compared topopulation
select location,population ,max(total_cases) as infectionCount,population,max((total_cases/population))*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
group by location,population
order by PopulationPercentageInfected desc;

--Countries with the highest death count per population
select location,population ,max(total_deaths) as DeathCount,max((total_deaths/population))*100 as PopulationPercentageDeath
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null
group by location,population
order by PopulationPercentageDeath desc;


--Continent  with the highest death count per population
select continent, max(cast(total_deaths as int)) as totaldeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
group by continent
order by totaldeaths;

--Entire world
select date,sum(new_cases) as SumOfnewCases, sum(cast(new_deaths as int)) as SumofNewDeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
group by date
order by 1;

select sum(new_cases) as SumOfnewCases, sum(cast(new_deaths as int)) as SumofNewDeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
order by 1;

--Joining the tables
select * 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and dea.date=vac.date;

--looking at total population vs vaccinations
select dea.continent,dea.location,dea.population, sum(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as Vaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null and vac.new_vaccinations is not null
order by 2,3;

--Creating Views
create view Vaccinated as
select dea.continent,dea.location,dea.population, sum(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as Vaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null and vac.new_vaccinations is not null;

create view Entireworld as
select date,sum(new_cases) as SumOfnewCases, sum(cast(new_deaths as int)) as SumofNewDeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
group by date;

create view TotalPopulationVsVaccinations as
select dea.continent,dea.location,dea.population, sum(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as Vaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null and vac.new_vaccinations is not null;

CREATE VIEW HighestDeathCountPerPopulation as
select continent, max(cast(total_deaths as int)) as totaldeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
group by continent

create view ContinentWithHighestDeathCount as
select continent, max(cast(total_deaths as int)) as totaldeaths
from PortfolioProject..CovidDeaths
where continent is not null and total_deaths is not null
group by continent

create view HighestInfectionRate as
select max(total_cases) as infectionCount,max((total_cases/population))*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null

create view TotalCasesVsPopulationInUS AS
select location,date,total_cases,population,(total_cases/population)*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is  not null and total_deaths is not null

create view TotalCasesVsPopulation as
select location,date,total_cases,population,(total_cases/population)*100 as PopulationPercentageInfected
from PortfolioProject..CovidDeaths
where continent is  not null and total_deaths is not null

create view TotalDeathsVsTotalCases as
select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where  location like '%states%' and total_deaths is not null

--Viewing a view
select * from TotalCasesVsPopulation








