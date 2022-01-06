const findTheOldest = function() {
  const oldest = arguments[0].sort((a,b) => {
    const lastPerson = (a.yearOfDeath !== undefined) ? a.yearOfDeath - a.yearOfBirth : new Date().getFullYear() - a.yearOfBirth;
    const nextPerson = (b.yearOfDeath !== undefined) ? b.yearOfDeath - b.yearOfBirth : new Date().getFullYear() - b.yearOfBirth;
    return lastPerson > nextPerson ? -1 : 1;
}); 
return oldest[0];
}

// Do not edit below this line
module.exports = findTheOldest;

