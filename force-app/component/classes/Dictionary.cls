/**
 * Used for Pre-Processing, the Dictionary caches a pre-defined normalization and replacement for common characters
 * found in names and adresses.
 *
 */
public class Dictionary {

  private static final Logger LOGGER = LoggerFactory.getLogger(Dictionary.class);
  public static final Map<String, String> addressDictionary = getAddressDictionary();
  public static final Map<String, String> nameDictionary = getNameDictionary();
  private static final String ADDRESS_DICTIONARY {
    get {
      if (ADDRESS_DICTIONARY == null) {
        ADDRESS_DICTIONARY = getResource('addressdictionary');
      }
      return ADDRESS_DICTIONARY;
    }
  }
  private static final String NAME_DICTIONARY {
    get {
      if (NAME_DICTIONARY == null) {
        NAME_DICTIONARY = getResource('namedictionary');
      }
      return NAME_DICTIONARY;
    }
  }

  private static String getResource(String resource) {
    try {
      StaticResource resource = [
        SELECT Id, Body
        FROM StaticResource
        WHERE Name = :resource
      ];
      return resource.Body.toString();
    } catch (Exception e) {
      LOGGER.error('Could not load resource');
      throw new MatchException('Could not load resource', e);
    }
  }

  private static Map<String, String> getAddressDictionary() {
    return getDictionary(ADDRESS_DICTIONARY);
  }

  private static Map<String, String> getNameDictionary() {
    return getDictionary(NAME_DICTIONARY);
  }

  private static Map<String, String> getDictionary(String body) {
    Map<String, String> dictionary = new Map<String, String>();
    List<String> lines = body.split('\n');
    for (String line : lines) {
      List<String> parts = line.split(':');
      if (parts.size() == 2) {
        dictionary.put(parts[0], parts[1]);
      }
    }
  }
}
