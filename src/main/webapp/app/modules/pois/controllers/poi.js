function Poi() {}

Poi.asPoi = function (jsonPoi) {
	return angular.extend(new Poi(), jsonPoi);
};