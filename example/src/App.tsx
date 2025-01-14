import { Text, View, StyleSheet } from 'react-native';
import RNChecksum from 'react-native-checksum';

const bundleChecksum = RNChecksum.getBundleChecksum();

export default function App() {
  return (
    <View style={styles.container}>
      <Text>bundleChecksum: {bundleChecksum}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
