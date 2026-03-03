class UserInteraction {
  bool liked;
  bool favorited;
  bool isOwner;

  UserInteraction({
    required this.liked,
    required this.favorited,
    required this.isOwner,
  });

  factory UserInteraction.fromJson(Map<String, dynamic> json) {
    return UserInteraction(
      liked: json['liked'] as bool,
      favorited: json['favorited'] as bool,
      isOwner: json['is_owner'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'liked': liked,
    'favorited': favorited,
    'is_owner': isOwner,
  };
}
