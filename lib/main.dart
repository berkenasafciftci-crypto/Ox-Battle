import 'package:flutter/material.dart';

void main() {
	runApp(const OxfordWordsApp());
}

class OxfordWordsApp extends StatelessWidget {
	const OxfordWordsApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Oxford Words',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				useMaterial3: true,
				scaffoldBackgroundColor: const Color(0xFFF2E6D5),
				colorScheme: ColorScheme.fromSeed(
					seedColor: const Color(0xFF8B4518),
					surface: const Color(0xFFF2E6D5),
				),
			),
			home: const LoginScreen(),
		);
	}
}

class LoginScreen extends StatefulWidget {
	const LoginScreen({super.key});

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final TextEditingController _nameController = TextEditingController();

	@override
	void dispose() {
		_nameController.dispose();
		super.dispose();
	}

	void _login() {
		final name = _nameController.text.trim();
		if (name.isEmpty) {
			ScaffoldMessenger.of(context)
				..hideCurrentSnackBar()
				..showSnackBar(
					const SnackBar(content: Text('Lütfen kullanıcı adınızı girin.')),
				);
			return;
		}

		ScaffoldMessenger.of(context)
			..hideCurrentSnackBar()
			..showSnackBar(SnackBar(content: Text('Hoş geldin, $name!')));
	}

	void _showPrivacyNotice() {
		showDialog<void>(
			context: context,
			builder: (context) => AlertDialog(
				backgroundColor: const Color(0xFFFFF8EE),
				title: const Text('Kullanıcı Bilgilendirme ve Aydınlatma Metni'),
				content: const SingleChildScrollView(
					child: Text(
						'Oxford Words, kullanıcı adınızı uygulama deneyimini kişiselleştirmek '
						'için kullanır. Bu örnek ekranda bilgileriniz herhangi bir sunucuya '
						'gönderilmez veya saklanmaz.',
					),
				),
				actions: [
					TextButton(
						onPressed: () => Navigator.of(context).pop(),
						child: const Text('Kapat'),
					),
				],
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.sizeOf(context);

		return Scaffold(
			body: SafeArea(
				child: LayoutBuilder(
					builder: (context, constraints) {
						final height = constraints.maxHeight;
						final contentWidth = size.width > 520 ? 393.0 : size.width;

						return Center(
							child: SizedBox(
								width: contentWidth,
								height: height,
								child: Stack(
									children: [
										Positioned(
											top: height * 0.105,
											left: 20,
											right: 20,
											child: const Text(
												'OXFORD\nWORDS',
												textAlign: TextAlign.center,
												style: TextStyle(
													color: Color(0xFF713811),
													fontFamily: 'serif',
													fontSize: 31,
													height: 1.25,
													letterSpacing: 0.3,
												),
											),
										),
										Positioned(
											top: height * 0.405,
											left: 46,
											right: 46,
											child: SizedBox(
												height: 42,
												child: TextField(
													controller: _nameController,
													textInputAction: TextInputAction.go,
													onSubmitted: (_) => _login(),
													style: const TextStyle(
														color: Color(0xFF713811),
														fontSize: 14,
													),
													decoration: InputDecoration(
														hintText: 'Kullanıcı Adı',
														hintStyle: const TextStyle(
															color: Color(0xFFB7A88F),
															fontSize: 14,
														),
														prefixIcon: const Icon(
															Icons.bookmark_border_rounded,
															size: 19,
															color: Color(0xFF713811),
														),
														filled: true,
														fillColor: const Color(0xFFEACD9F),
														contentPadding: const EdgeInsets.symmetric(
															vertical: 9,
														),
														border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(24),
															borderSide: BorderSide.none,
														),
														enabledBorder: OutlineInputBorder(
															borderRadius: BorderRadius.circular(24),
															borderSide: BorderSide.none,
														),
														focusedBorder: OutlineInputBorder(
															borderRadius: BorderRadius.circular(24),
															borderSide: const BorderSide(
																color: Color(0xFFB66B32),
																width: 1.2,
															),
														),
													),
												),
											),
										),
										Positioned(
											top: height * 0.565,
											left: 0,
											right: 0,
											child: Center(
												child: SizedBox(
													width: 208,
													height: 60,
													child: DecoratedBox(
														decoration: BoxDecoration(
															gradient: const LinearGradient(
																colors: [
																	Color(0xFFF5CB7E),
																	Color(0xFFE99450),
																],
															),
															borderRadius: BorderRadius.circular(32),
															boxShadow: const [
																BoxShadow(
																	color: Color(0x4D603A1C),
																	blurRadius: 8,
																	offset: Offset(0, 5),
																),
															],
														),
														child: Material(
															color: Colors.transparent,
															child: InkWell(
																onTap: _login,
																borderRadius: BorderRadius.circular(32),
																child: const Row(
																	mainAxisAlignment: MainAxisAlignment.center,
																	children: [
																		Text(
																			'Giriş',
																			style: TextStyle(
																				color: Color(0xFF713811),
																				fontSize: 20,
																				fontWeight: FontWeight.w700,
																			),
																		),
																		SizedBox(width: 9),
																		Icon(
																			Icons.play_arrow_rounded,
																			color: Color(0xFF713811),
																			size: 25,
																		),
																	],
																),
															),
														),
													),
												),
											),
										),
										Positioned(
											top: height * 0.835,
											left: 12,
											right: 12,
											child: Center(
												child: TextButton(
													onPressed: _showPrivacyNotice,
													style: TextButton.styleFrom(
														foregroundColor: const Color(0xFF6678FF),
														padding: const EdgeInsets.symmetric(
															horizontal: 8,
															vertical: 6,
														),
														minimumSize: Size.zero,
														tapTargetSize: MaterialTapTargetSize.shrinkWrap,
													),
													child: const Text(
														'Kullanıcı Bilgilendirme ve Aydınlatma Metni',
														textAlign: TextAlign.center,
														style: TextStyle(
															fontSize: 12,
															fontWeight: FontWeight.w500,
														),
													),
												),
											),
										),
									],
								),
							),
						);
					},
				),
			),
		);
	}
}

