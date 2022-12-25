capicua = function () {
	lst = db.phones.find();
	t = 0
	lst.forEach(element => {
		v = element.display.split("-")[1]
		normal = v.split("")
		reversed = normal.slice().reverse()
		if (equalArrays(normal, reversed)) {
			print(v)
			t+=1
		}
	});
	print("Número total de capicuas:", t)
}

function equalArrays(normal, reversed) {
	for (let index = 0; index < normal.length; index++) {
		if (normal[index] !== reversed[index])
			return false
	}
	return true
}