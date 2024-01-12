import 'package:code_factory_middle/common/const/colors.dart';
import 'package:code_factory_middle/rating/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage
  // AssetImage
  //
  // CircleAvatar
  final ImageProvider avatarImage;

  // 리스트로 위젯 이미지를 보여줄때
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰 내용
  final String content;
  const RatingCard({
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
    Key? key,
  }) : super(key: key);
  factory RatingCard.fromModel({
    required RatingModel model,
  }) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(
          height: 8,
        ),
        _Body(
          content: content,
        ),
        // image가 있으면 아래와 같이 차지
        if (images.isNotEmpty)
          SizedBox(
            height: 100,
            child: _Images(
              images: images,
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;
  const _Header({
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => (index < rating)
              ? const Icon(
                  Icons.star,
                  color: PRIMARY_COLOR,
                )
              : const Icon(
                  Icons.star_border,
                ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;
  const _Images({required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          // 마지막 데이터에는 패딩을 넣고 싶지 않다는 이유 등으로 사용
          .mapIndexed(
            (index, e) => Padding(
              padding: EdgeInsets.only(
                right: index == images.length - 1 ? 0 : 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          // flexible 안에 넣은 글자는 줄을 넘어가면 자연스럽게 다음 줄로 간다.
          // 사용하지 않으면 꽉 차면 오류 발생.
          child: Text(
            content,
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
