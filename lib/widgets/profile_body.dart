import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/screens/profile_screen.dart';
import 'package:instagram_two_record/widgets/profile_side_menu.dart';
import 'package:instagram_two_record/widgets/rounded_avatar.dart';

class ProfileBody extends StatefulWidget {
  final Function? onMenuChanged;

  const ProfileBody({Key? key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size!.width;

  AnimationController? _iconAnimationController;

  @override
  void initState() {
    //해당 state가 새로 생성이되었을때
    // TODO: implement initState
    _iconAnimationController =
        AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _iconAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(common_gap),
                        child: RoundedAvatar(
                          size: 80,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: common_gap),
                          child: Table(
                            children: [
                              TableRow(children: [
                                _valueText('167'),
                                _valueText('1024'),
                                _valueText('869')
                              ]),
                              TableRow(children: [
                                _valueTextSubject('POST'),
                                _valueTextSubject('Followers'),
                                _valueTextSubject('Following')
                              ])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  _username(),
                  _userBio(),
                  _editProfileBtn(),
                  _tapButtons(),
                  _selectedIndicator()
                ])),
                _imagesPager()
              ],
            ),
          ) //스크롤 가능한 여러 위젯이 있을때 섞어서 쓰는용도
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
          'JunKyeom Kim',
          textAlign: TextAlign.center,
        )),
        IconButton(
          onPressed: () {
            widget.onMenuChanged!();
            _iconAnimationController!.status == AnimationStatus.completed
                ? _iconAnimationController!.reverse()
                : _iconAnimationController!.forward();
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController!.view,
          ),
        )
      ],
    );
  }

  Text _valueText(String value) => Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  Text _valueTextSubject(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
        child: Stack(
      children: [
        AnimatedContainer(
          duration: duration,
          transform: (Matrix4.translationValues(_leftImagesPageMargin, 0, 0)),
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
        AnimatedContainer(
          duration: duration,
          transform: (Matrix4.translationValues(_rightImagesPageMargin, 0, 0)),
          curve: Curves.fastOutSlowIn,
          child: _images2(),
        )
      ],
    ));
  }

  GridView _images() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
          30,
          (index) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: 'https://picsum.photos/id/$index/100/100')),
      crossAxisCount: 3,
      childAspectRatio: 1,
    );
  }
  GridView _images2() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
          30,
              (index) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: 'https://picsum.photos/id/${index + 10}/100/100')),
      crossAxisCount: 3,
      childAspectRatio: 1,
    );
  }
  Row _tapButtons() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround, //아이콘 양쪽에 동일간격의 패딩
      children: [
        Expanded(
          child: IconButton(
            onPressed: () {
              _tapSelected(SelectedTab.left);
            },
            icon: ImageIcon(
              AssetImage('assets/images/grid.png'),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              _tapSelected(SelectedTab.right);
            },
            icon: ImageIcon(
              AssetImage('assets/images/saved.png'),
              color: _selectedTab == SelectedTab.left
                  ? Colors.black26
                  : Colors.black,
            ),
          ),
        )
      ],
    );
  }

  _tapSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          // TODO: Handle this case.

          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size!.width;
          break;
        case SelectedTab.right:
          // TODO: Handle this case.
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size!.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlinedButton(
          //borderSide: BorderSide(color: Colors.black45),
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),*/
          style: OutlinedButton.styleFrom(
              primary: Colors.black87,
              side: BorderSide(color: Colors.black45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'Kim Jun Kyeom',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'Kyumstagram',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: duration,
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size!.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }
}

enum SelectedTab { left, right }
