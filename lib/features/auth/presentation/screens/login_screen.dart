import '../../../../../core.dart';
import '../../../../app/theme/app_color.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'user@notes.com');
  final _passwordController = TextEditingController(text: 'user123');
  final _formKey = GlobalKey<FormState>();

  // bool _isAdmin = false;
  final ValueNotifier<bool> _isAdmin = ValueNotifier(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRoleChanged(bool isAdmin) {
    _isAdmin.value = isAdmin;

    if (_isAdmin.value) {
      _emailController.text = 'admin@notes.com';
      _passwordController.text = 'admin123';
    } else {
      _emailController.text = 'user@notes.com';
      _passwordController.text = 'user123';
    }
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(AuthEvent.login(email: _emailController.text.trim(), password: _passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (_) {
              context.goNamed(AppRoute.dashboard.name);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    Container(
                      height: 140,
                      decoration: BoxDecoration(gradient: AppColor.primaryGradient, borderRadius: BorderRadius.circular(28)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.note_alt_rounded, size: 48, color: Colors.white),
                          const SizedBox(height: 12),
                          Text(
                            'My Notes',
                            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Offline Notes with Role Based Access',
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    Text('Login', style: theme.textTheme.headlineSmall),

                    const SizedBox(height: 8),

                    Text('Choose a role and continue', style: theme.textTheme.bodyMedium?.copyWith(color: AppColor.grey)),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColor.lightGrey),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _isAdmin,
                        builder: (context, isAdmin, child) {
                          return Row(
                            children: [
                              Expanded(
                                child: _RoleTab(label: 'User', selected: !isAdmin, onTap: () => _onRoleChanged(false)),
                              ),
                              Expanded(
                                child: _RoleTab(label: 'Admin', selected: isAdmin, onTap: () => _onRoleChanged(true)),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                            validator: (value) {
                              final email = value?.trim() ?? '';

                              if (email.isEmpty) {
                                return 'Please enter email';
                              }

                              const emailPattern = r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$';

                              if (!RegExp(emailPattern).hasMatch(email)) {
                                return 'Please enter a valid email';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    ElevatedButton(
                      onPressed: isLoading ? null : _onLogin,
                      child: isLoading
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                          : ValueListenableBuilder(
                              valueListenable: _isAdmin,
                              builder: (context, isAdmin, child) {
                                return Text(isAdmin ? 'Login as Admin' : 'Login as User');
                              },
                            ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Demo Credentials', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 12),
                          Text('User\nuser@notes.com\nuser123', style: theme.textTheme.bodyMedium),
                          const SizedBox(height: 12),
                          Text('Admin\nadmin@notes.com\nadmin123', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoleTab extends StatelessWidget {
  const _RoleTab({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        gradient: selected ? AppColor.primaryGradient : null,
        color: selected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
