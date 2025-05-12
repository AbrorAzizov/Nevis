abstract class ProfileScreenState {
  final bool canQuit;
  const ProfileScreenState({required this.canQuit});
}

class ProfileInitial extends ProfileScreenState {
  const ProfileInitial({required super.canQuit});
}

class SuccessfullyQuitedFromProfileState extends ProfileScreenState {
  const SuccessfullyQuitedFromProfileState() : super(canQuit: false);
}
