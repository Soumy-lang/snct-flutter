import '../../models/admin/train_model.dart';

class TrainService {
  List<Train> _trains = [];

  List<Train> getAllTrains() => _trains;

  void addTrain(Train train) {
    _trains.add(train);
  }

  void updateTrain(String id, Train updatedTrain) {
    _trains = _trains.map((t) => t.id == id ? updatedTrain : t).toList();
  }

  void deleteTrain(String id) {
    _trains.removeWhere((t) => t.id == id);
  }
}
