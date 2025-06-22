### mindmap
  # root((Data Operations & Table Services))
    Write Operations
      COMMIT
        - Atomic write of batch records to base files
      DELTA_COMMIT
        - Atomic write of batch records to merge-on-read table
        - Data potentially written to delta logs
      REPLACE_COMMIT
        - Atomically replaces file groups
        - Used for insert_overwrite, delete_partition, clustering

    Table Services
      CLEANS
        - Removes older, unneeded file slices/files
      COMPACTION
        - Reconciles differential data
        - Merges delta files into base files
      LOGCOMPACTION
        - Merges small log files into larger ones
      CLUSTERING
        - Rewrites file groups for optimized sort/storage
      INDEXING
        - Builds specified index on a column
        - Consistent with table state at completed instant
      ROLLBACK
        - Indicates unsuccessful write rollback
        - Removes partial/uncommitted files
      SAVEPOINT
        - Marks file slices as "saved" (prevents cleaning)
        - Enables point-in-time restore/time-travel queries
      RESTORE
        - Restores table to a given savepoint
        - Used for disaster/data recovery