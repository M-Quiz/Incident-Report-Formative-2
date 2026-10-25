import 'package:flutter/material.dart';

const _ink = Color(0xFF172B27);
const _muted = Color(0xFF74817D);
const _green = Color(0xFF287A5B);
const _canvas = Color(0xFFF7F8F6);
const _line = Color(0xFFE9EDE9);

void main() {
  runApp(const CampusCareApp());
}

class CampusCareApp extends StatefulWidget {
  const CampusCareApp({super.key});

  @override
  State<CampusCareApp> createState() => _CampusCareAppState();
}

class _CampusCareAppState extends State<CampusCareApp> {
  bool _signedIn = false;
  String _email = '';
  final List<CampusIssue> _issues = List.of(_sampleIssues);

  void _signIn(String email) {
    setState(() {
      _email = email;
      _signedIn = true;
    });
  }

  void _signOut() {
    setState(() => _signedIn = false);
  }

  void _addIssue(CampusIssue issue) {
    setState(() => _issues.insert(0, issue));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _green,
          surface: Colors.white,
          onSurface: _ink,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: _canvas,
          foregroundColor: _ink,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF4F6F4),
          hintStyle: const TextStyle(color: _muted),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _green, width: 1.5),
          ),
        ),
      ),
      home: _signedIn
          ? CampusShell(
              email: _email,
              issues: _issues,
              onSignOut: _signOut,
              onIssueCreated: _addIssue,
            )
          : SignInScreen(onSignIn: _signIn),
    );
  }
}

class CampusIssue {
  const CampusIssue({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.status,
    required this.reportedBy,
    required this.time,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String category;
  final String location;
  final String description;
  final String status;
  final String reportedBy;
  final String time;
  final IconData icon;
  final Color color;
}

const _sampleIssues = [
  CampusIssue(
    id: 'CC-2048',
    title: 'Leaking tap in the north wing',
    category: 'Plumbing',
    location: 'Main Library · Level 2',
    description:
        'The tap beside the accessible washroom has been dripping continuously since this morning.',
    status: 'In progress',
    reportedBy: 'Avery K.',
    time: '18 min ago',
    icon: Icons.water_drop_outlined,
    color: Color(0xFF417EAF),
  ),
  CampusIssue(
    id: 'CC-2047',
    title: 'Lights out in study room 3B',
    category: 'Electrical',
    location: 'Hawthorne Hall · Room 3B',
    description:
        'Two overhead lights are not turning on, making the study room quite dim.',
    status: 'Open',
    reportedBy: 'Jordan M.',
    time: '52 min ago',
    icon: Icons.bolt_outlined,
    color: Color(0xFFC38B31),
  ),
  CampusIssue(
    id: 'CC-2046',
    title: 'Heating is not working',
    category: 'Heating & cooling',
    location: 'Science Centre · Lab 114',
    description:
        'The lab is unusually cold and the wall thermostat display is blank.',
    status: 'Open',
    reportedBy: 'Sam R.',
    time: '2 hours ago',
    icon: Icons.thermostat_outlined,
    color: Color(0xFFCC6B4F),
  ),
  CampusIssue(
    id: 'CC-2045',
    title: 'Accessible door button needs repair',
    category: 'Accessibility',
    location: 'Student Union · East entrance',
    description:
        'The automatic door push button does not respond. The door opens manually.',
    status: 'Resolved',
    reportedBy: 'Casey L.',
    time: 'Yesterday',
    icon: Icons.accessible_forward,
    color: Color(0xFF8060A8),
  ),
];

class SignInScreen extends StatefulWidget {
  const SignInScreen({required this.onSignIn, super.key});

  final ValueChanged<String> onSignIn;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSignIn(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _BrandMark(size: 58),
                    const SizedBox(height: 36),
                    const Text(
                      'A better campus,\none report at a time.',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 32,
                        height: 1.16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sign in to report a problem or see what’s happening around campus.',
                      style: TextStyle(color: _muted, fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    const _FieldCaption('University email'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                      decoration: const InputDecoration(
                        hintText: 'you@university.edu',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(email)) {
                          return 'Enter a valid university email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    const _FieldCaption('Password'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          tooltip: _obscurePassword
                              ? 'Show password'
                              : 'Hide password',
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) => (value?.length ?? 0) < 8
                          ? 'Password must be at least 8 characters'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: _green,
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: _line)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('CAMPUS COMMUNITY',
                              style: TextStyle(
                                  color: _muted,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2)),
                        ),
                        Expanded(child: Divider(color: _line)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    OutlinedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.account_balance_outlined),
                      label: const Text('Continue with university email'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _ink,
                        minimumSize: const Size.fromHeight(52),
                        side: const BorderSide(color: _line),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Your campus community, working together for spaces that work.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CampusShell extends StatefulWidget {
  const CampusShell({
    required this.email,
    required this.issues,
    required this.onSignOut,
    required this.onIssueCreated,
    super.key,
  });

  final String email;
  final List<CampusIssue> issues;
  final VoidCallback onSignOut;
  final ValueChanged<CampusIssue> onIssueCreated;

  @override
  State<CampusShell> createState() => _CampusShellState();
}

class _CampusShellState extends State<CampusShell> {
  int _selectedIndex = 0;

  Future<void> _openReport() async {
    final issue = await Navigator.of(context).push<CampusIssue>(
      MaterialPageRoute(
        builder: (_) => ReportWizard(
          onSubmit: (issue) => Navigator.of(context).pop(issue),
        ),
      ),
    );
    if (!mounted) return;
    if (issue != null) {
      widget.onIssueCreated(issue);
      setState(() => _selectedIndex = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your report has been submitted.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      FeedScreen(issues: widget.issues),
      MyReportsScreen(
        issues: widget.issues
            .where((issue) => issue.reportedBy == 'You')
            .toList(),
      ),
      ProfileScreen(email: widget.email, onSignOut: widget.onSignOut),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      floatingActionButton: _selectedIndex == 2
          ? null
          : FloatingActionButton.extended(
              onPressed: _openReport,
              backgroundColor: _green,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Report an issue',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE4F1EA),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Campus',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'My reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({required this.issues, super.key});

  final List<CampusIssue> issues;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _searchController = TextEditingController();
  String _filter = 'All';
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.issues.where((issue) {
      final matchesFilter = _filter == 'All' ||
          (_filter == 'Active'
              ? issue.status != 'Resolved'
              : issue.status == 'Resolved');
      final searchText =
          '${issue.title} ${issue.category} ${issue.location}'.toLowerCase();
      return matchesFilter && searchText.contains(_query.toLowerCase());
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 108),
      children: [
        Row(
          children: [
            const _BrandMark(size: 42),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CAMPUS CARE',
                      style: TextStyle(
                          color: _green,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5)),
                  SizedBox(height: 2),
                  Text('Your campus, together',
                      style: TextStyle(
                          color: _ink,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Notifications',
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('You’re all caught up on notifications.')),
              ),
              icon: const Icon(Icons.notifications_none_rounded),
              style: IconButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: _ink),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('CAMPUS COMMUNITY',
                    style: TextStyle(
                        color: Color(0xFFBCE5CC),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Little things make\na better campus.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6),
              ),
              const SizedBox(height: 10),
              const Text(
                'Spot something? Let’s get it sorted.',
                style: TextStyle(color: Color(0xFFD0DAD5), fontSize: 13),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _HeroStat(
                      number: '${widget.issues.where((i) => i.status != 'Resolved').length}',
                      label: 'being handled'),
                  const SizedBox(width: 24),
                  _HeroStat(
                      number:
                          '${widget.issues.where((i) => i.status == 'Resolved').length}',
                      label: 'fixed together'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value.trim()),
          decoration: InputDecoration(
            hintText: 'Search issues or locations',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Clear search',
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                    icon: const Icon(Icons.close),
                  ),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            const Expanded(
              child: Text('Campus feed',
                  style: TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3)),
            ),
            Text('${filtered.length} reports',
                style: const TextStyle(color: _muted, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['All', 'Active', 'Resolved'].map((filter) {
            final selected = _filter == filter;
            return ChoiceChip(
              label: Text(filter),
              selected: selected,
              showCheckmark: false,
              onSelected: (_) => setState(() => _filter = filter),
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFFE4F1EA),
              side: BorderSide(color: selected ? _green : _line),
              labelStyle: TextStyle(
                color: selected ? _green : _muted,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        if (filtered.isEmpty)
          const _EmptyState(
            icon: Icons.search_off_rounded,
            title: 'No reports found',
            message: 'Try another search or filter to explore the campus feed.',
          )
        else
          ...filtered.map(
            (issue) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: IssueCard(
                issue: issue,
                onTap: () => showIssueDetails(context, issue),
              ),
            ),
          ),
      ],
    );
  }
}

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({required this.issues, super.key});

  final List<CampusIssue> issues;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        const Text('My reports',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.w800, color: _ink)),
        const SizedBox(height: 6),
        const Text('Keep up with the issues you’ve raised.',
            style: TextStyle(color: _muted, fontSize: 14)),
        const SizedBox(height: 20),
        if (issues.isEmpty)
          const _EmptyState(
            icon: Icons.assignment_turned_in_outlined,
            title: 'Your reports live here',
            message:
                'When you report a campus issue, you can follow its progress here.',
          )
        else
          ...issues.map(
            (issue) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: IssueCard(
                issue: issue,
                onTap: () => showIssueDetails(context, issue),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {required this.email, required this.onSignOut, super.key});

  final String email;
  final VoidCallback onSignOut;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _updatesEnabled = true;

  String get _displayName {
    final rawName = widget.email.split('@').first.replaceAll(
        RegExp(r'[._-]+'), ' ');
    return rawName
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final initials = _displayName
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        const Text('Profile',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.w800, color: _ink)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _line),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFE4F1EA),
                child: Text(initials.isEmpty ? 'C' : initials,
                    style: const TextStyle(
                        color: _green,
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_displayName,
                        style: const TextStyle(
                            color: _ink,
                            fontWeight: FontWeight.w800,
                            fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(widget.email,
                        style: const TextStyle(color: _muted, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.school_outlined, color: _green, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionLabel('PREFERENCES'),
        const SizedBox(height: 8),
        _SettingsTile(
          icon: Icons.notifications_outlined,
          title: 'Report updates',
          subtitle: 'Get notified when a report changes',
          trailing: Switch.adaptive(
            value: _updatesEnabled,
            activeTrackColor: _green,
            onChanged: (enabled) => setState(() => _updatesEnabled = enabled),
          ),
        ),
        const SizedBox(height: 22),
        const _SectionLabel('ACCOUNT & SECURITY'),
        const SizedBox(height: 8),
        const _SettingsTile(
          icon: Icons.mail_outline,
          title: 'University email',
          subtitle: 'Campus account',
          trailing: Icon(Icons.chevron_right, color: _muted),
        ),
        const SizedBox(height: 10),
        const _SettingsTile(
          icon: Icons.phonelink_lock_outlined,
          title: 'Active session',
          subtitle: 'This device · Signed in now',
          trailing: Icon(Icons.circle, color: _green, size: 10),
        ),
        const SizedBox(height: 10),
        const _SettingsTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy',
          subtitle: 'Your campus community profile',
          trailing: Icon(Icons.chevron_right, color: _muted),
        ),
        const SizedBox(height: 26),
        OutlinedButton.icon(
          onPressed: widget.onSignOut,
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Sign out'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFB74545),
            minimumSize: const Size.fromHeight(52),
            side: const BorderSide(color: Color(0xFFE9DADA)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 20),
        const Text('CAMPUS CARE  ·  VERSION 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _muted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1)),
      ],
    );
  }
}

class ReportWizard extends StatefulWidget {
  const ReportWizard({required this.onSubmit, super.key});

  final ValueChanged<CampusIssue> onSubmit;

  @override
  State<ReportWizard> createState() => _ReportWizardState();
}

class _ReportWizardState extends State<ReportWizard> {
  final _formKey = GlobalKey<FormState>();
  final _buildingController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  int _step = 0;
  String? _category;
  String? _building;

  static const _categories = [
    _CategoryChoice('Plumbing', Icons.water_drop_outlined, Color(0xFF417EAF)),
    _CategoryChoice('Electrical', Icons.bolt_outlined, Color(0xFFC38B31)),
    _CategoryChoice(
        'Heating & cooling', Icons.thermostat_outlined, Color(0xFFCC6B4F)),
    _CategoryChoice('Cleaning', Icons.cleaning_services_outlined, _green),
    _CategoryChoice('Accessibility', Icons.accessible_forward, _green),
    _CategoryChoice(
        'Other facilities', Icons.construction_outlined, Color(0xFF8060A8)),
  ];

  @override
  void dispose() {
    _buildingController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step == 0 && _category == null) {
      _showMessage('Choose an issue type to continue.');
      return;
    }
    if (_step == 1) {
      if (_building == null) {
        _showMessage('Choose a building or campus area.');
        return;
      }
      if (_building == 'Other' && _buildingController.text.trim().isEmpty) {
        _showMessage('Enter the building or campus area.');
        return;
      }
      if (_locationController.text.trim().isEmpty) {
        _showMessage('Add a room, floor, or nearby landmark.');
        return;
      }
    }
    if (_step == 2 && !_formKey.currentState!.validate()) return;
    if (_step < 3) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _submit() {
    final choice = _categories.firstWhere((item) => item.name == _category);
    final building =
        _building == 'Other' ? _buildingController.text.trim() : _building!;
    widget.onSubmit(
      CampusIssue(
        id: 'CC-${DateTime.now().millisecondsSinceEpoch % 10000}',
        title: _titleController.text.trim(),
        category: choice.name,
        location: '$building · ${_locationController.text.trim()}',
        description: _descriptionController.text.trim(),
        status: 'Open',
        reportedBy: 'You',
        time: 'Just now',
        icon: choice.icon,
        color: choice.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const stepNames = ['Issue type', 'Location', 'Details', 'Review'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Close report',
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('New report',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
              child: Column(
                children: [
                  Row(
                    children: List.generate(4, (index) {
                      final done = index <= _step;
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin:
                              EdgeInsets.only(right: index == 3 ? 0 : 7),
                          decoration: BoxDecoration(
                            color: done ? _green : const Color(0xFFE4E9E5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Expanded(
                        child: Text('STEP ${_step + 1} OF 4',
                            style: const TextStyle(
                                color: _green,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.1)),
                      ),
                      Text(stepNames[_step],
                          style: const TextStyle(
                              color: _muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
                  children: [_buildCurrentStep()],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _line)),
              ),
              child: Row(
                children: [
                  if (_step > 0)
                    OutlinedButton(
                      onPressed: () => setState(() => _step--),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(54, 52),
                        foregroundColor: _ink,
                        side: const BorderSide(color: _line),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  if (_step > 0) const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: _next,
                      style: FilledButton.styleFrom(
                        backgroundColor: _green,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _step == 3 ? 'Submit report' : 'Continue',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          const SizedBox(width: 8),
                          Icon(_step == 3
                              ? Icons.check_circle_outline
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WizardHeading(
              title: 'What needs attention?',
              subtitle: 'Pick the category that best fits your report.',
            ),
            const SizedBox(height: 22),
            ..._categories.map((category) {
              final selected = _category == category.name;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => setState(() => _category = category.name),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFFF0F7F2) : Colors.white,
                      border: Border.all(
                          color: selected ? _green : _line,
                          width: selected ? 1.5 : 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: category.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(category.icon, color: category.color),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(category.name,
                              style: const TextStyle(
                                  color: _ink,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: selected ? _green : const Color(0xFFB8C1BC),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WizardHeading(
              title: 'Where is it?',
              subtitle: 'A precise location helps the right team find it.',
            ),
            const SizedBox(height: 22),
            const _FieldCaption('Building or campus area'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _building,
              isExpanded: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.apartment_outlined),
                hintText: 'Choose a building',
              ),
              items: const [
                'Main Library',
                'Student Union',
                'Science Centre',
                'Hawthorne Hall',
                'Athletics Centre',
                'Other',
              ].map((name) => DropdownMenuItem(value: name, child: Text(name)))
                  .toList(),
              onChanged: (value) => setState(() => _building = value),
            ),
            if (_building == 'Other') ...[
              const SizedBox(height: 16),
              const _FieldCaption('Building name'),
              const SizedBox(height: 8),
              TextField(
                controller: _buildingController,
                decoration: const InputDecoration(
                    hintText: 'Enter the building or campus area'),
              ),
            ],
            const SizedBox(height: 18),
            const _FieldCaption('Room, floor, or nearby landmark'),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.place_outlined),
                hintText: 'e.g. Level 2, room 204',
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WizardHeading(
              title: 'Tell us a little more.',
              subtitle: 'Share enough detail for us to understand the issue.',
            ),
            const SizedBox(height: 22),
            const _FieldCaption('Short title'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              maxLength: 70,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'What is the issue?',
                counterStyle: TextStyle(color: _muted, fontSize: 10),
              ),
              validator: (value) => (value?.trim().length ?? 0) < 5
                  ? 'Add a short title (at least 5 characters).'
                  : null,
            ),
            const SizedBox(height: 12),
            const _FieldCaption('Description'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              minLines: 5,
              maxLines: 7,
              maxLength: 500,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'What happened? When did you notice it?',
                alignLabelWithHint: true,
                counterStyle: TextStyle(color: _muted, fontSize: 10),
              ),
              validator: (value) => (value?.trim().length ?? 0) < 10
                  ? 'Please add a little more detail.'
                  : null,
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline, size: 18, color: _green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Please don’t include private information in your report.',
                      style: TextStyle(
                          color: _ink, fontSize: 12, height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        final category =
            _categories.firstWhere((item) => item.name == _category);
        final building =
            _building == 'Other' ? _buildingController.text : _building;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WizardHeading(
              title: 'Ready to send?',
              subtitle: 'Check your report before sharing it with campus.',
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _line),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: category.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(category.icon, color: category.color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(_titleController.text.trim(),
                            style: const TextStyle(
                                color: _ink,
                                fontWeight: FontWeight.w800,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  const Divider(height: 28, color: _line),
                  _ReviewRow(
                      icon: Icons.category_outlined, text: _category ?? ''),
                  const SizedBox(height: 12),
                  _ReviewRow(
                    icon: Icons.place_outlined,
                    text: '${building ?? ''} · ${_locationController.text}',
                  ),
                  const SizedBox(height: 14),
                  Text(_descriptionController.text.trim(),
                      style: const TextStyle(
                          color: _muted, height: 1.5, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'By submitting, you’re sharing this report with your campus facilities team and community.',
              style: TextStyle(color: _muted, fontSize: 12, height: 1.5),
            ),
          ],
        );
    }
  }
}

class IssueCard extends StatelessWidget {
  const IssueCard({required this.issue, required this.onTap, super.key});

  final CampusIssue issue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final resolved = issue.status == 'Resolved';
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: _line)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: issue.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(issue.icon, color: issue.color, size: 21),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(issue.title,
                            style: const TextStyle(
                                color: _ink,
                                fontSize: 14,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 5),
                        Text(issue.category,
                            style: const TextStyle(
                                color: _muted, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: _muted),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.place_outlined, size: 15, color: _muted),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(issue.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _muted, fontSize: 11)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: _line),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatusBadge(
                    text: issue.status,
                    color: resolved ? _green : const Color(0xFF9B711B),
                    background: resolved
                        ? const Color(0xFFE8F3EC)
                        : const Color(0xFFFAF0D9),
                  ),
                  const Spacer(),
                  Text('${issue.reportedBy} · ${issue.time}',
                      style: const TextStyle(color: _muted, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showIssueDetails(BuildContext context, CampusIssue issue) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                        color: _line, borderRadius: BorderRadius.circular(3)))),
            const SizedBox(height: 22),
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: issue.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(issue.icon, color: issue.color),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(issue.category,
                          style:
                              const TextStyle(color: _muted, fontSize: 12)),
                      Text(issue.id,
                          style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                    ],
                  ),
                ),
                _StatusBadge(
                  text: issue.status,
                  color:
                      issue.status == 'Resolved' ? _green : const Color(0xFF9B711B),
                  background: issue.status == 'Resolved'
                      ? const Color(0xFFE8F3EC)
                      : const Color(0xFFFAF0D9),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(issue.title,
                style: const TextStyle(
                    color: _ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    height: 1.25)),
            const SizedBox(height: 12),
            _ReviewRow(icon: Icons.place_outlined, text: issue.location),
            const SizedBox(height: 6),
            Text(issue.description,
                style:
                    const TextStyle(color: _muted, fontSize: 14, height: 1.6)),
            const SizedBox(height: 19),
            const Divider(color: _line),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 17, color: _muted),
                const SizedBox(width: 6),
                Text('Reported by ${issue.reportedBy}',
                    style: const TextStyle(color: _muted, fontSize: 12)),
                const Spacer(),
                Text(issue.time,
                    style: const TextStyle(color: _muted, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

class _CategoryChoice {
  const _CategoryChoice(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _green,
          borderRadius: BorderRadius.circular(size * 0.32),
        ),
        child: Icon(Icons.hub_rounded, color: Colors.white, size: size * 0.55),
      );
}

class _FieldCaption extends StatelessWidget {
  const _FieldCaption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            color: _ink, fontSize: 13, fontWeight: FontWeight.w700),
      );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            color: _muted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1),
      );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _line),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 21, color: _green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: _ink,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: const TextStyle(color: _muted, fontSize: 11)),
                ],
              ),
            ),
            trailing,
          ],
        ),
      );
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.number, required this.label});
  final String number;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20)),
          Text(label,
              style: const TextStyle(color: Color(0xFFCFD8D3), fontSize: 11)),
        ],
      );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.text,
    required this.color,
    required this.background,
  });

  final String text;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: FontWeight.w700)),
      );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _line),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: _green, size: 32),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    color: _ink, fontSize: 15, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _muted, height: 1.5, fontSize: 12)),
          ],
        ),
      );
}

class _WizardHeading extends StatelessWidget {
  const _WizardHeading({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: _ink,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6)),
          const SizedBox(height: 7),
          Text(subtitle,
              style:
                  const TextStyle(color: _muted, fontSize: 13, height: 1.45)),
        ],
      );
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 16, color: _muted),
          const SizedBox(width: 7),
          Expanded(
            child: Text(text,
                style: const TextStyle(color: _muted, fontSize: 12)),
          ),
        ],
      );
}
