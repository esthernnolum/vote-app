import 'package:voting_app/constants/election_data.dart';
import 'package:voting_app/constants/keys.dart';
import 'package:voting_app/core/app_utils.dart';
import 'package:voting_app/core/voting_app_viewmodel.dart';
import 'package:voting_app/features/voting/view/cast_vote_view.dart';
import 'package:voting_app/models/enums/election_category.dart';
import 'package:voting_app/util/notification.dart';

class ViewCandidatesViewModel extends VotingAppViewmodel {
  /// States and variables =====================================================
  late ELECTIONCATEGORY _electioncategory;
  ELECTIONCATEGORY get electioncategory => _electioncategory;
  set electioncategory(ELECTIONCATEGORY newValue) {
    _electioncategory = newValue;
    notifyListeners();
  }

  String? _selectdState;
  String? get selectdState => _selectdState;
  set selectdState(String? newValue) {
    _selectdState = newValue;
    notifyListeners();
  }

  String? _selectdLocalGovernment;
  String? get selectdLocalGovernment => _selectdLocalGovernment;
  set selectdLocalGovernment(String? newValue) {
    _selectdLocalGovernment = newValue;
    notifyListeners();
  }

  List _candidates = [];
  List get candidates => _candidates;
  set candidates(List newValue) {
    _candidates = newValue;
    notifyListeners();
  }

  /// Methods ==================================================================

  onReady({
    required ELECTIONCATEGORY electioncategory_,
    String? selectedState_,
    String? selectedLocalGovernment_,
  }) {
    electioncategory = electioncategory_;
    selectdLocalGovernment = selectedLocalGovernment_;
    selectdState = selectedState_;
    getCandidates();
  }

  back() {
    navigationService.back();
  }

  // toViewCandidates({required ELECTIONCATEGORY electionCategory}) {
  //   navigationService
  //       .navigateToView(CastVoteView(electionCategory: electionCategory));
  // }

  getCandidates() async {
    logger.d(" The election type is ${electioncategory.name}");
    switch (electioncategory) {
      case ELECTIONCATEGORY.presidential:
        final result = await db.getPresidentialCandidates();
        logger.d("The first party is ${result.values.toList()[0]}");
        candidates = result.values.toList();
        break;
      case ELECTIONCATEGORY.gubernatorial:
        if (selectdState == null) {
          AppNotification.notify(
              notificationMessage:
                  "A state is needed to get gubernatorial candidates");
        }
        final result =
            await db.getGubernatorialCandidates(state: selectdState!);
        candidates = result.values.toList();
        break;
      case ELECTIONCATEGORY.localGovernment:
        if (selectdState == null || selectdLocalGovernment == null) {
          AppNotification.notify(
              notificationMessage:
                  "A state and local government is needed to get gubernatorial candidates");
        }
        final result = await db.getLocalGovernmentCandidates(
          state: selectdState!,
          localGovernment: selectdLocalGovernment!,
        );
        candidates = result.values.toList();
        break;
    }
  }
}
