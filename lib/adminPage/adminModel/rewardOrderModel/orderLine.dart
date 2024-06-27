import 'package:wizzsales/adminPage/adminModel/rewardOrderModel/rewardOrderModel.dart';

class RewardOrderLine {
  int? id;
  dynamic rewardOrderId;
  dynamic convertedRewardId;
  dynamic costToUserAsPoint;
  dynamic costToSystemAsPoint;
  dynamic costToUserAsCurrency;
  dynamic costToSystemAsCurrency;
  String? costCurrencyType;
  Reward? reward;

  RewardOrderLine({
    this.id,
    this.rewardOrderId,
    this.convertedRewardId,
    this.costToUserAsPoint,
    this.costToSystemAsPoint,
    this.costToUserAsCurrency,
    this.costToSystemAsCurrency,
    this.costCurrencyType,
    this.reward,
  });

  factory RewardOrderLine.fromJson(Map<String, dynamic> json) => RewardOrderLine(
    id: json["id"],
    rewardOrderId: json["rewardOrderId"],
    convertedRewardId: json["convertedRewardId"],
    costToUserAsPoint: json["costToUserAsPoint"],
    costToSystemAsPoint: json["costToSystemAsPoint"],
    costToUserAsCurrency: json["costToUserAsCurrency"],
    costToSystemAsCurrency: json["costToSystemAsCurrency"],
    costCurrencyType: json["costCurrencyType"],
    reward: Reward.fromJson(json["reward"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rewardOrderId": rewardOrderId,
    "convertedRewardId": convertedRewardId,
    "costToUserAsPoint": costToUserAsPoint,
    "costToSystemAsPoint": costToSystemAsPoint,
    "costToUserAsCurrency": costToUserAsCurrency,
    "costToSystemAsCurrency": costToSystemAsCurrency,
    "costCurrencyType": costCurrencyType,
    "reward": reward!.toJson(),
  };
}