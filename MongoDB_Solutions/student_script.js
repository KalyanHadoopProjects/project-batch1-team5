db.student1_json.find( { id: { $gt: 2 }, course: 'spark' }, { _id: 0, course: 0, year: 0});
