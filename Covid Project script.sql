SELECT * FROM [Portfolio Project]..CovidDeathsInfo
where continent is not null
order by 3,4

SELECT * FROM [Portfolio Project]..CovidVaccinationInfo
order by 3,4

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM [Portfolio Project]..CovidDeathsInfo
order by 1,2

-- Looking at total cases vs total deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location,date,total_cases,new_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio Project]..CovidDeathsInfo
Where location like '%india%'
and continent is not null
order by 1,2

--Looking at total cases vs population
--Shows what percentage of population got covid

SELECT location,date, population, total_cases,(total_cases/population)*100 as PercentPopulationInfected
FROM [Portfolio Project]..CovidDeathsInfo
--Where location like '%india%'
order by 1,2

-- Looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases)as HighestInfectioncount, Max(total_cases/population)*100 as PercentPopulationInfected
FROM [Portfolio Project]..CovidDeathsInfo
--Where location like '%india%'
Group by location, population
order by PercentPopulationInfected desc

--Showing countries with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathcount
FROM [Portfolio Project]..CovidDeathsInfo
--Where location like '%india%'
where continent is not null
Group by location
order by TotalDeathcount desc

-- By Continent


--Showing continents with highest death count per populations

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathcount
FROM [Portfolio Project]..CovidDeathsInfo
--Where location like '%india%'
where continent is not null
Group by continent
order by TotalDeathcount desc

-- Global Numbers

SELECT SUM(new_cases) as total_cases ,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM [Portfolio Project]..CovidDeathsInfo
--Where location like '%india%'
where continent is not null
--group by date
order by 1,2

--total population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

from [Portfolio Project]..CovidDeathsInfo dea
Join [Portfolio Project]..CovidVaccinationInfo vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
order by 2,3


--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

from [Portfolio Project]..CovidDeathsInfo dea
Join [Portfolio Project]..CovidVaccinationInfo vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--order by 2,3
)
Select * , (RollingPeopleVaccinated/Population)*100
from PopvsVac 

-- Temp table
DROP table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date ) as RollingPeopleVaccinated

from [Portfolio Project]..CovidDeathsInfo dea
Join [Portfolio Project]..CovidVaccinationInfo vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--order by 2,3

Select * , (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated

-- creating view to store data for visualizations

Create view PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date ) as RollingPeopleVaccinated

from [Portfolio Project]..CovidDeathsInfo dea
Join [Portfolio Project]..CovidVaccinationInfo vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--order by 2,3

Select *
from PercentPopulationVaccinated